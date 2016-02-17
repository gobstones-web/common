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
    #observe:
    #  type: String
    #  value: ''
      
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
    #observables = @observe.trim().split(/\s*,\s*/)
    #for observable in observables
    #  if observable isnt ''
    #    #console.log @_parentPropPrefix + observable
    #    @_addObserverEffect (@_parentPropPrefix + observable), 'update_annotations'
  
  ###  
  update_annotations: ->
    console.log @
    console.log 'change_index'
    console.log @_notes
    @_flushTemplates()
    @async ->
      for instance in @_instances
        console.log instance._notes
      @_debounceTemplate ->
  ###  
    
  render: ->
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
      #stamp deletes model attributes value
      #does not use 'self.stamp(model)'
      if @_parentProps
        templatized = @_templatized;
        for prop of @_parentProps
          #this 'if' fix self attribute override problem
          if not model.hasOwnProperty prop
            model[prop] = templatized[@_parentPropPrefix + prop];
          #else
          #  console.log 'own: ' + model[prop]
          #  console.log 'templatized: ' + templatized[@_parentPropPrefix + prop]
          #  console.log 'skiping ' + prop
      instance = new @ctor(model, @)
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
  
  _changed: ->
    @_debounceTemplate ->
      @_update()
  
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
  
  



