import 'dart:math';

abstract class GraphWeight{  
  Map<int, Map<int,int>> w_graph = {};  
  Map<int, Map<int,int>> get weight_graph {return this.w_graph;}  

  GraphWeight()  
  {    
    generate_graph();  
  }  

  void generate_graph();  

  void create_empty_graph(var numberOfVertices)
  {
    for (var i = 1; i <= numberOfVertices; i++) 
    {
      w_graph[i]={};
    }
  }

  void print_graph()  
  {
    for (var element in w_graph.entries)    
    {      
      print(element);    
    }    
    print('\n');  
  }
}
