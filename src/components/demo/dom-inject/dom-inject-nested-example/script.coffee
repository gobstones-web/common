Polymer
  is: '#GRUNT_COMPONENT_NAME'
  
  ready: ->
    @_simple = document.createElement('dom-inject-simple-example')
    @simpleElement = @_simple