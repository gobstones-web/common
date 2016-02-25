Polymer
  is: '#GRUNT_COMPONENT_NAME'
  
  properties:
    simpleElement:
      type: Object
      
  listeners:
    'toggleSimple.tap': '_toggle_simple'
    'toggleNested.tap': '_toggle_nested'
  
  ready: ->
    @_simple = document.createElement('dom-inject-simple-example')
    @simpleElement = @_simple
    @_nested = document.createElement('dom-inject-nested-example')
    @nestedElement = @_nested

  _toggle_simple:->
    if @simpleElement
      @simpleElement = null
    else
      @simpleElement = @_simple
      
  _toggle_nested:->
    if @nestedElement
      @nestedElement = null
    else
      @nestedElement = @_nested
      
