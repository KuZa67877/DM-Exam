import 'Graphs.dart';
import 'dart:math';

class DirectedRandGraph extends MyGraph {
  @override
  void generate_graph() {
    create_empty_graph();
    var random = Random();

    for (var i = 1; i <= graph.length; i++) {
      for (var j = 1; j <= graph.length; j++) {
        var len = graph[i]?.length ?? 0;
        if (len == 3) break;
        if (!(graph[j]?.contains(i) ?? false) &&
            random.nextDouble() < 0.5 &&
            i != j) {
          graph[i]?.add(j);
        }
      }
    }
  }
}
