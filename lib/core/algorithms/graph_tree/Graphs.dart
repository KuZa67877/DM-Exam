import 'dart:math';

abstract class Graph{  
  Map<int, Set<int>> _graph = {};  
  Map<int, Set<int>> get graph {return this._graph;}  

  Graph()  
  {    
    generate_graph();  
  }  

  void generate_graph();  

  void create_empty_graph()
  {
    var random = Random();
    var numberOfVertices = random.nextInt(3) + 8;

    for (var i = 1; i <= numberOfVertices; i++) 
    {
      graph[i]={};
    }
  }

  void print_graph()  
  {
    for (var element in graph.entries)    
    {      
      print(element);    
    }    
    print('\n');  
  }
}