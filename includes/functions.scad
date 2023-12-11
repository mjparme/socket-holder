// Sum N elements of an array
function addList(list, l, c = 0) = c < l ? list[c] + addList(list, l, c + 1) : list[c];

// Sum All elments of Array
function addArray(v) = [for (p = v) 1] * v;