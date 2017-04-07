// qui vengono definiti gli stili che saranno mostrati nel dropdown degli editor inline
// gli stili dovranno avere una corrispondenza nei css del sito

CKEDITOR.stylesSet.add( 'my_styles', [
    // Object-level styles
    { name: 'Menu', element: 'ul', attributes: { 'class': 'vertical medium-horizontal menu' } },
    { name: 'Bottone (primary)', element: 'a', attributes: { 'class': 'button' } },
    { name: 'Bottone (secondary)', element: 'a', attributes: { 'class': 'secondary button' } },
    { name: 'Bottone (success)', element: 'a', attributes: { 'class': 'success button' } },
    { name: 'Bottone (warning)', element: 'a', attributes: { 'class': 'warning button' } },
    { name: 'Bottone (alert)', element: 'a', attributes: { 'class': 'alert button' } },
    { name: 'Bottone (disabled)', element: 'a', attributes: { 'class': 'disabled button' } },

    { name: 'Bottone vuoto (primary)', element: 'a', attributes: { 'class': 'hollow button' } },
    { name: 'Bottone vuoto (secondary)', element: 'a', attributes: { 'class': 'hollow secondary button' } },
    { name: 'Bottone vuoto (success)', element: 'a', attributes: { 'class': 'hollow success button' } },
    { name: 'Bottone vuoto (warning)', element: 'a', attributes: { 'class': 'hollow warning button' } },
    { name: 'Bottone vuoto (alert)', element: 'a', attributes: { 'class': 'hollow alert button' } },
    { name: 'Bottone vuoto (disabled)', element: 'a', attributes: { 'class': 'hollow disabled button' } },

    { name: 'Immagine estesa', element: 'img', styles: { 'width': '100%' } },
    { name: 'Immagine circolare', element: 'img', attributes: { 'class': 'immagine-circolare' } },

    // Block-level styles
    { name: 'Titolo' , element: 'h1', attributes: { } },
    { name: 'Sottotitolo' , element: 'h2', attributes: { } },

    // Inline styles
    { name: 'Data', element: 'span', attributes: { 'class': 'data' } },
    { name: 'Abstract', element: 'span', attributes: { 'class': 'abstract' } },
    { name: 'Autore', element: 'span', attributes: { 'class': 'autore' } },
    { name: 'Fonte', element: 'span', attributes: { 'class': 'fonte' } },
    { name: 'Tag', element: 'ul', attributes: { 'class': 'etichetta' } },
    // { name: 'Marker: Yellow', element: 'span', styles: { 'background-color': 'Yellow' } },
] );
