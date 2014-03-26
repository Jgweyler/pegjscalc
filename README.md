Analizador de PL0 Ampliado Usando PEG.js
========================================

**Objetivo:** 

Reescribir el analizador sintáctico del lenguaje PL0 realizado en la práctica del `Analizador Descendente Predictivo Recursivo` usando `PEG.js`.

El material de inicio necesario para la realización se encuentra en:

*Repositorio:* https://github.com/crguezl/pegjscalc
*Despliegue Heroku:* http://pegjspl0.herokuapp.com

```bash
[~/srcPLgrado/pegjscalc(master)]$ pwd -P
/Users/casiano/local/src/javascript/PLgrado/pegjscalc
```
```bash
[~/srcPLgrado/pegjscalc(master)]$ git remote -v
heroku  git@heroku.com:pegjspl0.git (fetch)
heroku  git@heroku.com:pegjspl0.git (push)
origin  git@github.com:crguezl/pegjscalc.git (fetch)
origin  git@github.com:crguezl/pegjscalc.git (push)
```

**Tareas**

* Modificar `block` y `statement` para que los procedure reciban argumentos y las llamadas a procedimiento puedan pasar argumentos.
* Actualice la documentación de la gramática para que refleje la gramática ampliada
* Limitar el número de programas que se pueden salvar a un número prefijado, por ejemplo 10. Si se intenta salvar uno se suprime uno al azar y se guarda el nuevo.
* Las pruebas deben comprobar que la asociatividad a izquierdas funciona bien, y probar todos los constructos del lenguaje así como alguna situación de error.

**Referencias de apoyo:**                                                                                           
http://nereida.deioc.ull.es/~plgrado/javascriptexamples/node80.html#chapter:heroku                           
https://devcenter.heroku.com/articles/heroku-postgresql                                                                
http://nereida.deioc.ull.es/~plgrado/javascriptexamples/node88.html#chapter:datamapper

**Componentes del Grupo:**                                                                                  
Jorge Gómez Weyler.     https://github.com/alu4399                                                     
Víctor Hernández Pérez. https://github.com/alu0100697032
___________________________________
**Asignatura:** Procesadores De Lenguajes.                                                                  
**Curso:** 3º de Grado en Ingeniería Informática.                                                                      
**Centro:** Escuela Técnica Superior de Ingeniería Informática. Universidad de La Laguna.


