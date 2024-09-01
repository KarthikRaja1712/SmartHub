List<List<int>> winningCombinations = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6],
];

String getWinner(List<String> board) {
  for (var combination in winningCombinations) {
    if (board[combination[0]] != '' &&
        board[combination[0]] == board[combination[1]] &&
        board[combination[1]] == board[combination[2]]) {
      return board[combination[0]];
    }
  }
  return '';
}
