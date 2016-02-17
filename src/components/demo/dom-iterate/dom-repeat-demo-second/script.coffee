Polymer
  is: '#GRUNT_COMPONENT_NAME'
  
  properties: 
    secondLevelToIndex:
      type: Number
      value: 2
      observer: 'mk_array'
      
    secondLevelFromIndex:
      type: Number
      value: 0
      observer: 'mk_array'
      
    firstItem:
      type: Number
    
    second_items:
      type: Array
      value: []
      
    secondLevelIncludeLast:
      type: Boolean
      value: false
      observer: 'mk_array'
      
  mk_array: (count)->
    _from = parseInt @secondLevelFromIndex
    _to   = parseInt @secondLevelToIndex
    if _from <= _to
      #increment mode
      @secondLevelIncludeLast and _to += 1
    else 
      #decrement mode
      @secondLevelIncludeLast and _to -= 1
    
    @second_items = (item for item in [_from ... _to])
    
