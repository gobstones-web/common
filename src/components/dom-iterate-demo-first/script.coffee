Polymer
  is: '#GRUNT_COMPONENT_NAME'
  
  properties: 
    
    items: 
      type: Array
      value: [1, 2, 3, 4]
    
    firstLevelFromIndex:
      type: Number
      value: 0
      observer: 'mk_array'
      
    firstLevelToIndex:
      type: Number
      value: 3
      observer: 'mk_array'
      
    firstLevelIncludeLast:
      type: Boolean
      value: false
      
    secondLevelToIndex:
      type: Number
      value: 2
      notify: true
      
  ready: ->
    console.log @
    
  mk_array: (count)->
    @items = (item for item in [@firstLevelFromIndex ... @firstLevelToIndex])
    console.log @items
