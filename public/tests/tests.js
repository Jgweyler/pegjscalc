var assert = chai.assert;

suite('Tests', function(){
  
  test('Asignacion: ', function(){
    object = pl0.parse("y = 3. ")
    assert.equal(object.block.st.type, "=")
    assert.equal(object.block.st.left.type, "ID")
    assert.equal(object.block.st.left.value, "y")
    assert.equal(object.block.st.right.type, "NUM")
    assert.equal(object.block.st.right.value, "3") 
  });

  test('Suma: ', function(){
    object = pl0.parse("z = 9 + 15 .")
    assert.equal(object.block.st.right.type, "+")
  });

  test('Multiplicacion: ', function(){
    object = pl0.parse("t = 20 * 81 .")
    assert.equal(object.block.st.right.type, "*") 
  });

  test('Division: ', function(){
    object = pl0.parse("u = 6 / 6 .")
    assert.equal(object.block.st.right.type, "/")
  });

  
  test('Asociatividad de izquierda: ', function(){
    object = pl0.parse("x = 10-20-30 .")
    assert.equal(object.block.st.right.left.type, "-") 
  });
  
  test('Parentesis: ', function(){
    object = pl0.parse("x = (21+45) * 10 .")
    assert.equal(object.block.st.right.left.type, "+")
  });
  
  test('Precedencia: ', function(){
    object = pl0.parse("x = 20+2*7 .")
    assert.equal(object.block.st.right.left.type, "NUM")
  });

  test('Comparacion: ', function(){
    object = pl0.parse("if y == 11 then z = 22 .")
    assert.equal(object.block.st.condition.type, "==")
  });

  
  test('Call: ', function(){
    object = pl0.parse("call x .")
    assert.equal(object.block.st.type, "call")
  });

 
  test('While Do: ', function(){
    object = pl0.parse("while y == 13 do x = z+8.")
    assert.equal(object.block.st.type, "IF")
  });

  test('Begin End: ', function(){
    object = pl0.parse("begin y = 8; x = a+30 end.")
    assert.equal(object.type, "program")
  });

  test('Error de Sintaxis: ', function(){
    assert.throws(function() { pl0.parse("x = 123"); }, /Expected "."/);
  });

});