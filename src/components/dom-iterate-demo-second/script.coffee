Polymer
  is: '#GRUNT_COMPONENT_NAME'
  
  properties: 
    secondLevelToIndex:
      type: Number
      value: 2
      observer: 'mk_array'
      
  mk_array: (count)->
    console.log 'mk_array'
