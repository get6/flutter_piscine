void main() {
  Map<String, int> SpaceData = {
    'NGC 162': 1862,
    '87 Sylvia': 1866,
    'R 136a1': 1985,
    '28978 Ixion': 2001,
    'NGC 6715': 1778,
    '94400 Hongdaeyong': 2001,
    '6354 Vangelis': 1934,
    'C/2020 F3': 2020,
    'Cartwheel Galaxy': 1941,
    'Sculptor Dwarf Elliptical Galaxy': 1937,
    'Eight-Burst Nebula': 1835,
    'Rhea': 1672,
    'C/1702 H1': 1702,
    'Messier 5': 1702,
    'Messier 50': 1711,
    'Cassiopeia A': 1680,
    'Great Comet of 1680': 1680,
    'Butterfly Cluster': 1654,
    'Triangulum Galaxy': 1654,
    'Comet of 1729': 1729,
    'Omega Nebula': 1745,
    'Eagle Nebula': 1745,
    'Small Sagittarius Star Cloud': 1764,
    'Dumbbell Nebula': 1764,
    '54509 YORP': 2000,
    'Dia': 2000,
    '63145 Choemuseon': 2000,
  };
  SpaceData.entries.toList()
    ..sort((a, b) {
      if (a.value == b.value)
        return b.key.compareTo(a.key);
      else
        return a.value.compareTo(b.value);
    })
    ..forEach((entry) => print('${entry.key} : ${entry.value}'));

  // value가 중복되면 없어짐.
  // SplayTreeMap<String, int>.from(
  //   SpaceData,
  //   (key1, key2) => SpaceData[key1]!.compareTo(SpaceData[key2]!),
  // ).forEach((key, value) => print('$key : $value'));
}
