import './Node.dart';
import './Tree.dart';

class BinaryTree extends Tree
{
  @override
  void fill_tree() 
  {
    head = generateBalancedBST(List<int>.generate(this.size, (index) => index+1));
  }

  Node? sortedArrayToBST(List<int> nums) {
  if (nums.isEmpty) {
    return null;
  }

  int mid = nums.length ~/ 2;
  Node root = Node(nums[mid]);
  root.set_child(sortedArrayToBST(nums.sublist(0, mid)), 0);
  root.set_child(sortedArrayToBST(nums.sublist(mid + 1)), 1);

  return root;
}

void fillTreeBalanced(Node? root, List<int> nums) {
  if (root != null) 
  {
    return;
  }

  fillTreeBalanced(root?.childs[0], nums);
  root?.name = nums.removeAt(0);
  fillTreeBalanced(root?.childs[1], nums);
}

Node? generateBalancedBST(List<int> nums) {
  nums.sort();
  Node? root = sortedArrayToBST(nums);
  fillTreeBalanced(root, nums);
  return root;
}
}