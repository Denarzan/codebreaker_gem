MATCHING = { place: '+', presence: '-' }.freeze

module Helper
  ARRAY_EXAMPLES =
    [
      [[6, 5, 4, 1], [6, 5, 4, 1], %w[+ + + +]],
      [[1, 2, 2, 1], [2, 1, 1, 2], %w[- - - -]],
      [[6, 2, 3, 5], [2, 3, 6, 5], %w[+ - - -]],
      [[1, 2, 3, 4], [4, 3, 2, 1], %w[- - - -]],
      [[1, 2, 3, 4], [1, 2, 3, 5], %w[+ + +]],
      [[1, 2, 3, 4], [5, 4, 3, 1], %w[+ - -]],
      [[1, 2, 3, 4], [1, 5, 2, 4], %w[+ + -]],
      [[1, 2, 3, 4], [4, 3, 2, 6], %w[- - -]],
      [[1, 2, 3, 4], [3, 5, 2, 5], %w[- -]],
      [[1, 2, 3, 4], [5, 6, 1, 2], %w[- -]],
      [[5, 5, 6, 6], [5, 6, 0, 0], %w[+ -]],
      [[1, 2, 3, 4], [6, 2, 5, 4], %w[+ +]],
      [[1, 2, 3, 1], [1, 1, 1, 1], %w[+ +]],
      [[1, 1, 1, 5], [1, 2, 3, 1], %w[+ -]],
      [[1, 2, 3, 4], [4, 2, 5, 5], %w[+ -]],
      [[1, 2, 3, 4], [5, 6, 3, 5], ['+']],
      [[1, 2, 3, 4], [6, 6, 6, 6], []],
      [[1, 2, 3, 4], [2, 5, 5, 2], ['-']]
    ].freeze
  HASH_EXAMPLES = {
    [6, 5, 4, 3] => {
      [5, 6, 4, 3] => [MATCHING[:place], MATCHING[:place], MATCHING[:presence], MATCHING[:presence]],
      [6, 4, 1, 1] => [MATCHING[:place], MATCHING[:presence]],
      [6, 5, 4, 4] => [MATCHING[:place], MATCHING[:place], MATCHING[:place]],
      [3, 4, 5, 6] => [MATCHING[:presence], MATCHING[:presence], MATCHING[:presence], MATCHING[:presence]],
      [6, 6, 6, 6] => [MATCHING[:place]],
      [2, 6, 6, 6] => [MATCHING[:presence]],
      [2, 2, 2, 2] => []
    },
    [6, 6, 6, 6] => {
      [1, 6, 6, 1] => [MATCHING[:place], MATCHING[:place]],
      [1, 6, 6, 6] => [MATCHING[:place], MATCHING[:place], MATCHING[:place]],
      [6, 6, 6, 6] => [MATCHING[:place], MATCHING[:place], MATCHING[:place], MATCHING[:place]],
      [4, 4, 6, 6] => [MATCHING[:place], MATCHING[:place]],
      [6, 4, 6, 6] => [MATCHING[:place], MATCHING[:place], MATCHING[:place]]
    },
    [1, 2, 3, 4] => {
      [3, 1, 2, 4] => [MATCHING[:place], MATCHING[:presence], MATCHING[:presence], MATCHING[:presence]],
      [4, 3, 2, 1] => [MATCHING[:presence], MATCHING[:presence], MATCHING[:presence], MATCHING[:presence]],
      [1, 2, 3, 5] => [MATCHING[:place], MATCHING[:place], MATCHING[:place]],
      [5, 4, 3, 1] => [MATCHING[:place], MATCHING[:presence], MATCHING[:presence]],
      [1, 5, 2, 4] => [MATCHING[:place], MATCHING[:place], MATCHING[:presence]],
      [4, 3, 2, 6] => [MATCHING[:presence], MATCHING[:presence], MATCHING[:presence]],
      [3, 5, 2, 5] => [MATCHING[:presence], MATCHING[:presence]],
      [5, 6, 1, 2] => [MATCHING[:presence], MATCHING[:presence]],
      [6, 2, 5, 4] => [MATCHING[:place], MATCHING[:place]],
      [6, 6, 6, 6] => [],
      [4, 2, 5, 5] => [MATCHING[:place], MATCHING[:presence]],
      [5, 6, 3, 5] => [MATCHING[:place]],
      [2, 5, 5, 2] => [MATCHING[:presence]]
    },
    [6, 5, 4, 1] => {
      [6, 5, 4, 1] => [MATCHING[:place], MATCHING[:place], MATCHING[:place], MATCHING[:place]]
    },
    [1, 2, 2, 1] => {
      [2, 1, 1, 2] => [MATCHING[:presence], MATCHING[:presence], MATCHING[:presence], MATCHING[:presence]]
    },
    [6, 2, 3, 5] => {
      [2, 3, 6, 5] => [MATCHING[:place], MATCHING[:presence], MATCHING[:presence], MATCHING[:presence]]
    },
    [5, 5, 6, 6] => {
      [5, 6, 1, 1] => [MATCHING[:place], MATCHING[:presence]]
    },
    [1, 2, 3, 1] => {
      [1, 1, 1, 1] => [MATCHING[:place], MATCHING[:place]]
    },
    [1, 1, 1, 5] => {
      [1, 2, 3, 1] => [MATCHING[:place], MATCHING[:presence]]
    }
  }.freeze
end
