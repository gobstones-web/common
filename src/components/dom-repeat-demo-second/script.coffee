Polymer
  is: '#GRUNT_COMPONENT_NAME'
  
  properties: 
    secondLevelToIndex:
      type: Number
      value: 2
      observer: 'mk_array'
    firstIndex:
      type: Number
      
  mk_array: (count)->
    @first_items = (item for item in [0 ... @secondLevelToIndex])
