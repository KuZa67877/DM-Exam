import 'dart:math';

class MyGraph {
  Map<int, Set<int>> _graph = {};
  Map<int, int> workload = {}; //щагруженность вершин
  Map<int, Set<int>> get graph {
    return this._graph;
  }

  MyGraph() {
    generate_graph();
  }

  void generate_graph() {
    create_empty_graph();

    // Map<int, int> count_edges =
    // {
    //   0:graph.length,
    //   1:0,
    //   2:0,
    //   3:0
    // };
    graph[graph.length]?.add(1);
    graph[1]?.add(graph.length);
    workload[1] = (workload[1] ?? 0) + 1;
    workload[graph.length] = (workload[graph.length] ?? 0) + 1;
    var rand = Random();
    for (int i = 1; i < graph.length; i++) {
      graph[i]?.add(i + 1);
      graph[i + 1]?.add(i);
      workload[i] = (workload[i] ?? 0) + 1;
      workload[i + 1] = (workload[i + 1] ?? 0) + 1;
      if (rand.nextDouble() < 0.6 && (graph[i]?.length ?? 0) < 3) {
        int vertex = find_min();
        graph[i]?.add(vertex);
        graph[vertex]?.add(i);
        workload[vertex] = (workload[vertex] ?? 0) + 1;
        workload[i] = (workload[i] ?? 0) + 1;
      }
    }
  }

  void create_empty_graph() {
    var numberOfVertices = 12;

    for (var i = 1; i <= numberOfVertices; i++) {
      graph[i] = {};
      workload[i] = 0;
    }
  }

  int find_min() {
    var min = 1024;

    var random = Random();
    var ind;

    List<int> min_vertex = [];

    for (var pair in workload.entries) {
      if (pair.value < min) {
        min_vertex.clear();
        min_vertex.add(pair.key);
        min = pair.value;
      } else if (pair.value == min) min_vertex.add(pair.key);
    }
    ind = random.nextInt(min_vertex.length);
    var vertex = min_vertex[ind];
    return vertex;
  }

  void print_graph() {
    for (var element in graph.entries) {
      print(element);
    }
    print('\n');
  }
}
