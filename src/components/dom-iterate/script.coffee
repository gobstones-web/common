Polymer
  is: '#GRUNT_COMPONENT_NAME'
  extends: 'template'
  _template: null
  
  properties: 
    from: 
      type: Number
      value: 0
    to: 
      type: Number
      value: 0
    includeLast:
      type: Boolean
      value: true
    indexAs:
      type: String
      value: 'index'
      
  observers: [
      '_changed(from, to, includeLast)'
    ]
    
  behaviors: [
      Polymer.Templatizer
    ]
    
  created: ->
    @_instances = []
    @_from = 0
    @_to = 0
    
  ready: ->
    @_instanceProps = 
      __key__: true
    @_instanceProps[@indexAs] = true;
    unless @ctor then @templatize(@)
  
  render: ->
    console.log 'render'
    @_flushTemplates()

  attached: ->
    for instance in @_instances
      @_insertBefore instance

  detached: ->
    for instance in @_instances
      @_detachInstance(instance)
      
  _insertBefore: (instance, target)->
    target = target or {}
    parent = target.parent or @_getParentElement()
    before = target.before or @
    parent.insertBefore(instance.root, before)
    instance
    
  _attachInstances: ()->
    for index in [@_from ... @_to]
      model = {}
      model[@indexAs] = index
      instance = @stamp model
      @_insertBefore instance
      @_instances.push instance
        
  _detachInstance: (instance)->
    root = Polymer.dom instance.root
    if instance._children
      for child in instance._children
        unless child.isPlaceholder
          root.appendChild child

  _detachInstances: (start, count)->
    start = start or 0
    count = count or @_instances.length - start
    instances = @_instances.splice(start, count)
    self = this
    for instance in instances
      self._detachInstance instance
    
  _getParentElement: ->
    Polymer.dom(Polymer.dom(@).parentNode)
  
  _changed: (a, b, c)->
    @_debounceTemplate @_update
  
  _calculate_points: ->
    @_from = parseInt @from
    @_to   = parseInt @to
    if @from <= @to
      #increment mode
      @includeLast and @_to += 1
    else
      #decrement mode
      @includeLast and @_from -= 1
      
  _update: ->
    @_detachInstances()
    @_calculate_points()
    @_attachInstances()
  
  _forwardParentProp: (prop, value) ->
    instances = @_instances
    for instance in instances
      unless instance.isPlaceholder
        instance.__setProperty prop, value, true
    
  _forwardParentPath: (path, value) ->
    instances = @_instances
    for instance in instances
      unless instance.isPlaceholder
        instance._notifyPath path, value, true



