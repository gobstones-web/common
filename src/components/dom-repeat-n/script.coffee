Polymer
  is: '#GRUNT_COMPONENT_NAME'
  
  extends: 'template'
  
  _template: null
  
  properties:
    count:
      type: Number
      value: 0
      observer: '_countChanged'
    start:
      type: Number
      value: 0
      observer: '_startChanged'
    increment:
      type: Number
      value: 1
      observer: '_incrementChanged'
    indexAs:
      type: String
      value: 'index'
      
  behaviors: [ Polymer.Templatizer ]
  
  created: ->
    @_instances = []
    @_pool = []
    return
    
  ready: ->
    # Template instance props that should be excluded from forwarding
    @_instanceProps = {}
    @_instanceProps[@indexAs] = true
    # Templatizing (generating the instance constructor) needs to wait
    # until ready, since won't have its template content handed back to
    # it until then
    if !@ctor
      @templatize this
    return
    
  attached: ->
    parent = Polymer.dom(Polymer.dom(this).parentNode)
    i = 0
    while i < @_instances.length
      @_attachInstance i, parent
      i++
    return
    
  detached: ->
    i = 0
    while i < @_instances.length
      @_detachInstance i
      i++
    return
    
  _countChanged: (newCount, oldCount) ->
    if isNaN(newCount)    
      @count = oldCount
      console.error 'dom-repeat-n: count should be a number'
      return
    if typeof newCount != 'number'  
      newCount = parseInt newCount
    if newCount < 0
      @count = oldCount
      console.error 'dom-repeat-n: count cannot be negative'
      return
    # we use async to enable ready to be called before this code
    @async ->
      i = undefined
      # Generate possible missing instances if count increased
      i = 0
      while i < newCount
        inst = @_instances[i]
        if !inst
          inst = @_insertInstance(i)
        i++
      # Remove any extra instances from previous state
      limit = @_instances.length
      i = newCount
      while i < limit
        @_detachAndRemoveInstance i
        i++
      @_debounceTemplate @_render
      @fire 'dom-change'
      return
    return
    
  _startChanged: (newStart, oldStart) ->
    if typeof newStart != 'number'
      @start = oldStart
      console.error 'dom-repeat-n: start should be a number'
      return
    @_debounceTemplate @_render
    return
    
  _incrementChanged: (newIncrement, oldIncrement) ->
    if typeof newIncrement != 'number'
      @increment = oldIncrement
      console.error 'dom-repeat-n: start should be a number'
      return
    @_debounceTemplate @_render
    return
    
  _render: ->
    i = 0
    while i < @count
      inst = @_instances[i]
      inst.__setProperty @indexAs, i * @increment + @start, true
      i++
    return
    
  _attachInstance: (idx, parent) ->
    inst = @_instances[idx]
    parent.insertBefore inst.root, this
    return
    
  _detachInstance: (idx) ->
    inst = @_instances[idx]
    i = 0
    while i < inst._children.length
      el = inst._children[i]
      Polymer.dom(inst.root).appendChild el
      i++
    inst
    
  _detachAndRemoveInstance: (idx) ->
    inst = @_detachInstance(idx)
    if inst
      @_pool.push inst
    @_instances.splice idx, 1
    return
    
  _stampInstance: (idx) ->
    model = {}
    model[@indexAs] = idx
    @stamp model
    
  _insertInstance: (idx) ->
    inst = @_pool.pop()
    if !inst
      inst = @_stampInstance(idx)
    beforeRow = @_instances[idx + 1]
    beforeNode = if beforeRow and !beforeRow.isPlaceholder then beforeRow._children[0] else this
    parentNode = Polymer.dom(this).parentNode
    Polymer.dom(parentNode).insertBefore inst.root, beforeNode
    @_instances.push inst
    inst
    
  _showHideChildren: (hidden) ->
    i = 0
    while i < @_instances.length
      @_instances[i]._showHideChildren hidden
      i++
    return
  
  



