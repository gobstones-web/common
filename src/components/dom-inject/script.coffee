Polymer
  is: '#GRUNT_COMPONENT_NAME'
  extends: 'template'
  properties: 
    element: 
      type: Object
      observer: '_update'
      
  created: ->
    
  ready: ->
    @_update()
    
  _reject: ()->
    if @_instance
      Polymer.dom(Polymer.dom(@).parentNode).removeChild(@_instance)
    @_instance = undefined
    
  _inject: (element)->
    Polymer.dom(Polymer.dom(@).parentNode).insertBefore(@element, @)
    @_instance = @element

  _update: ->
    if @element isnt @_instance
      @_reject()
      if typeof @element is 'object' and 
      @element instanceof HTMLElement
        @_inject @element
        





