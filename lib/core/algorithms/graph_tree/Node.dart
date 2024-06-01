class Node
{
  var _name;
  List<Node?> _childs = [];
  var _height;

  Node(this._name);

  int get name {return this._name;} 
  List<Node?> get childs {return this._childs;} 

  set childs(List<Node?> list) => this._childs = list;

  set name(int val) => this._name = val; 

  int get height
  {
    int leftHeight = _childs[0]?.height ?? 0;
    int rightHeight = _childs[1]?.height ?? 0;
    return 1 + (leftHeight > rightHeight ? leftHeight : rightHeight);
  }
}