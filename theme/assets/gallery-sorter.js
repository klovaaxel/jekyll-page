function sortGallery(gallery, images) {
    // Get the computed style values
    columnCount = window.getComputedStyle(gallery).columnCount;

    // Start a new array for each column
    const column3dArray = Array.from({ length: columnCount }, () => []);

    const averageImagesInColumn = Math.floor(images.length / columnCount);
    let activeColumn = 0;

    // Loop through the images and add them to the correct column
    for (let image of images) {
        // If the column is "full", go to the next column or start over
        if (column3dArray[activeColumn].length >= averageImagesInColumn) {
            activeColumn = (activeColumn + 1) % columnCount;
        }

        // Add the image to the column
        column3dArray[activeColumn].push(image);
        // Go to next column or start over
        activeColumn = (activeColumn + 1) % columnCount;
    }

    // concat all columns into one array
    const mergedArray = column3dArray.reduce(
        (acc, curr) => [...acc, ...curr],
        []
    );

    // Replace the gallery with the new sorted array
    gallery.innerHTML = "";
    const fragment = document.createDocumentFragment();
    for (let child of mergedArray) {
        fragment.appendChild(child);
    }
    gallery.appendChild(fragment);

    // Remove the loading class from the gallery
    gallery.classList.remove("gallery-loading");
}
