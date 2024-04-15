import 'Graphs.dart';
import 'dart:math';

class UndirectedRandGraph extends Graph
{
  @override
  void generate_graph() 
  {
    create_empty_graph();
    var random = Random();

    for (var i = 1; i < graph.length; i++) 
    {
      for (var j = i + 1; j <= graph.length; j++) 
      {
        if (random.nextDouble() < 0.5) 
        { 
          graph[i]?.add(j);
          graph[j]?.add(i);
        }
      }
    }
  }
}