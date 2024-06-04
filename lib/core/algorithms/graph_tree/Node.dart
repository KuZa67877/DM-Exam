class Node
{
  var _name;
  List<Node?> _childs = [];

  Node([this._name = 0]);

  int get name {return this._name;} 
  List<Node?> get childs {return this._childs;} 
  set name(int val) => this._name = val; 

  set_child(Node? element, int ind)
  {
    _childs[ind] = element ?? null;
  }

  // void print_node()
  // {
  //   print('$_name : $adj_ver \n');
  // }
}