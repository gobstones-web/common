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
      observer: 'mk_array'
      
    first_items:
      type: Array
      value: []
      
  ready: ->
    #console.log @
  
  _calculate_points: ->
      
  mk_array: (count)->
    _from = parseInt @firstLevelFromIndex
    _to   = parseInt @firstLevelToIndex
    if _from <= _to
      #increment mode
      @firstLevelIncludeLast and _to += 1
    else 
      #decrement mode
      @firstLevelIncludeLast and _to -= 1
    
    @first_items = (item for item in [_from ... _to])
    
