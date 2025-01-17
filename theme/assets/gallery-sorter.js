// Get the gallery and images
const galleries = [];
const gallerieElemnts = Array.from(
    document.querySelectorAll(".gallery")
);

// Loop through the galleries and add them to the array
for (i = 0; i < gallerieElemnts.length; i++)
    galleries.push({
        container: gallerieElemnts[i],
        images: Array.from(gallerieElemnts[i].children),
    });

// Hide the gallery while we sort it
for (gallery of galleries)
    gallery.container.classList.add("gallery-loading");

// When the window is resized, sort the gallery
window.addEventListener("resize", function (event) {
    for (gallery of galleries) {
        gallery.container.classList.add("gallery-loading");
        sortGallery(gallery.container, gallery.images);
    }
});

// When we load the page, sort the gallery
window.addEventListener("load", function (event) {
    for (gallery of galleries)
        sortGallery(gallery.container, gallery.images);
});

function stretchImages(columnCount, columnHeights, column3dArray) {
    // If we only have one column, we don't need to stretch the images
    if (columnCount == 1) return;

    // Get the longest column
    const longestColumn = Math.max(...columnHeights);

    // loop through each column
    for (let column of column3dArray) {
        // Sum the height of all images in the column
        const columnHeight = column
            .map((image) => parseInt(window.getComputedStyle(image).height.slice(0, -2)))
            .reduce((acc, curr) => acc + curr, 0);

        // Calculate the height difference
        const heightDifference = longestColumn - columnHeight;

        // Devide the height difference by the number of images in the column
        const heightToAdd = heightDifference / column.length;

        // Add the height to each image
        for (let image of column) {
            image.style.height = `${parseInt(window.getComputedStyle(image).height.slice(0, -2)) + heightToAdd}px`;
        }
    }
}

function sortGallery(gallery, images) {
    // Get the computed style values
    columnCount = window.getComputedStyle(gallery).columnCount;

    // Start a new array for each column
    const column3dArray = Array.from({ length: columnCount }, () => []);
    const columnHeights = Array.from({ length: columnCount }, () => 0);

    // Calculate the average height of all columns
    var totalImagesHeight = images
        .map((image) => parseInt(window.getComputedStyle(image).height.slice(0, -2)))
        .reduce((acc, curr) => acc + curr, 0);
    const averageHeight = totalImagesHeight / columnCount;

    let activeColumn = 0;

    // Loop through the images and add them to the correct column
    for (let image of images) {
        const imageHeight = parseInt(window.getComputedStyle(image).height.slice(0, -2));

        // If the column is "full", go to the next column or start over (only if the column is not empty)
        if (columnHeights[activeColumn] + imageHeight > averageHeight && columnHeights != 0) {
            activeColumn = (activeColumn + 1) % columnCount;
        }

        // Add the image to the column
        column3dArray[activeColumn].push(image);
        columnHeights[activeColumn] += imageHeight;
        // Go to next column or start over
        activeColumn = (activeColumn + 1) % columnCount;
    }

    // concat all columns into one array
    const mergedArray = column3dArray.reduce((acc, curr) => [...acc, ...curr], []);

    // Replace the gallery with the new sorted array
    gallery.innerHTML = "";
    const fragment = document.createDocumentFragment();
    for (let child of mergedArray) {
        fragment.appendChild(child);
    }
    gallery.appendChild(fragment);

    // Stretch the images to fill the columns
    stretchImages(columnCount, columnHeights, column3dArray);

    // Remove the loading class from the gallery
    gallery.classList.remove("gallery-loading");
}
