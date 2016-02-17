Polymer
  is: '#GRUNT_COMPONENT_NAME'
  
  properties: 
    
    firstLevelFromIndex:
      type: Number
      value: 0
      
    firstLevelToIndex:
      type: Number
      value: 3
      
    firstLevelIncludeLast:
      type: Boolean
      value: false
      
    secondLevelToIndex:
      type: Number
      value: 2
      #observer: '_secondLevelToIndexChange'
      
  #_secondLevelToIndexChange: ->
  #  console.log '_secondLevelToIndexChange'