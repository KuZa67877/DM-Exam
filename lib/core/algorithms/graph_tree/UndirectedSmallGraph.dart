import 'Graphs.dart';
import 'dart:math';

class UndirectedSmallGraph extends MyGraph {
  @override
  void generate_graph() {
    create_empty_graph();
    var random = Random();

    for (var i = 1; i <= graph.length; i++) {
      for (var j = i + 1; j <= graph.length; j++) {
        var len = max(graph[i]?.length ?? 0, graph[j]?.length ?? 0);
        if (len == 3) break;
        if (random.nextDouble() < 0.5 && i != j) {
          graph[i]?.add(j);
          graph[j]?.add(i);
        }
      }
    }
  }
}
