void main(){
  Map<String,dynamic> mp = {
    'key1' : 10,
    'key2' : "Akash",
    'key3' : 17.5
  };
  mp['key4'] = 100;
  print(mp);
  List<int> lst = [1,5,7];
  lst[0] = 100;
  print(lst[0]);
  Map<int,double> mps = {
    1:1.5,
    2:3.5
  };
  mps[5] = 100.2;
  print(mps);
}