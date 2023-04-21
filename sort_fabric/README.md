## Sort Program
### Usage

```
SortProgram(pathIn: 'in.txt', pathOut: 'out.txt', sortMethod: 'selection').execute();
```

### Additional information

Использована расширяемая абстрактная фабрика для инициализации разных методов сортировки. 
В качестве расширяемой абстрактной фабрики используется IoC контейнер SortIoC.

В задании было указано использовать для хранения начальных данных и результата файловую систему. 
При необходимости можно в используемый ioC контейнер добавлять зависимости для различных репозиториев.

![diagram](AbstractFabricaDiagram.png)

## MatrixGenerateProgram
### Usage

```
MatrixGenerateProgram(matrixRows: 3, matrixColumns: 4, f0: 'in.txt', f1: 'out.txt').execute();
```
``` 
MatrixSumProgram(ProgramInterface()).execute();
```

##  Additional information

Использован шаблон адаптер для передачи параметров из программы в подпрограмму

![diagram](AdapterDiagram.png)
