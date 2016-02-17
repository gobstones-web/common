Polymer
  is: '#GRUNT_COMPONENT_NAME'
  
  properties: 
    
    firstLevelFromIndex:
      type: Number
      value: 0
      
    firstLevelToIndex:
      type: Number
      value: 3
      observe: '_render'
      
    firstLevelIncludeLast:
      type: Boolean
      value: false
      
    secondLevelToIndex:
      type: Number
      value: 2
      
  is_greater:->
    @firstLevelFromIndex > 0