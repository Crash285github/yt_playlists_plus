enum PlaylistState {
  ///The Playlist data is currently downloading for the first time
  ///
  ///After the download finished, the state will change to `downloaded`
  downloading,

  ///The Playlist has downloaded and is ready for checking
  downloaded,

  ///The Playlist has not been checked yet
  ///
  ///This is the initial state when constructing a `Playlist`
  unChecked,

  ///The Playlist is currently being fetched
  ///
  ///After it finishes, the state should change to `checking`
  ///If fetching fails, the state will change to 'notFound'
  fetching,

  ///The Playlist is currently being checked
  ///
  ///After it finishes, the state will change to either
  ///'unchanged' or 'changed'
  checking,

  ///The Playlist has been checked, and nothing has changed
  unChanged,

  ///The Playlist has been checked, and there has been some changes
  changed,

  ///The Playlist itself can't be found on Youtube
  notFound
}
