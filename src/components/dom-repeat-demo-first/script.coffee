Polymer
  is: '#GRUNT_COMPONENT_NAME'
  
  properties: 
    
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
      
  ready: ->
    #console.log @
      
  mk_array: (count)->
    @first_items = (item for item in [@firstLevelFromIndex ... @firstLevelToIndex])
    
