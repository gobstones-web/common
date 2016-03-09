Polymer
  is: '#GRUNT_COMPONENT_NAME'
  extends: 'template'
  properties: 
    element: 
      type: Object
      observer: '_element_change'
      
  created: ->
    
  attached: ->
    @be_detached = false
    @_update()
    
  detached: ->
    @be_detached = true
    @_update()
    
  _reject: ()->
    if @_instance and @_instance.parentNode
      @_instance.parentNode.removeChild(@_instance)
    @_instance = undefined
    
  _inject: ()->
    Polymer.dom(Polymer.dom(@).parentNode).insertBefore(@element, @)
    @_instance = @element

  _update: ->
    if not @be_detached
      @_inject()
    else
      @_reject()
      
  _element_change: ->
    @_reject()
    if typeof @element is 'object' and 
    @element instanceof HTMLElement
      @_update()
        





