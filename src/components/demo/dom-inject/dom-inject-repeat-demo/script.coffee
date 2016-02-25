Polymer
  is: '#GRUNT_COMPONENT_NAME'
  
  properties:
    repeatElements:
      type: Array
      
  listeners:
    'generate.tap': '_generate'
    
  created:->
    @classes = ['red', 'orange', 'blue', 'green', 'pink' ]
    @current_class_index = 0
  
  next_class:->
    next_class = @classes[@current_class_index]
    if (@current_class_index += 1) is @classes.length
      @current_class_index = 0
    next_class
  
  ready: ->
    @repeatElements = []

  _generate:->
    _simple = document.createElement('dom-inject-simple-example')
    _simple.className += @next_class()
    @push 'repeatElements', _simple
      
  removeItem: (evnt)->
    item = evnt.target.item
    index = @repeatElements.indexOf item
    @splice 'repeatElements', index, 1