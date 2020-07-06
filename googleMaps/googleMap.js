var map;
var minVal;
var maxVal;

const dict = { Eco2: 1, Eco3: 2, Eco4: 3, Eco5: 4, Eco6: 5, Eco7: 6 };

async function initMap() {
  let bogota = { lat: 4.570868, lng: -74 };
  map = new google.maps.Map(document.getElementById("map"), {
    zoom: 10,
    center: bogota,
  });

  await d3.json("/googleMaps/datos/UTAM.json").then((data) => {
    const UTAMValues = data;

    map.data.addGeoJson(UTAMValues, {
      idPropertyName: "UTAM",
    });
  });
  map.data.setStyle(styleFeature);
  map.data.addListener("mouseover", mouseInToRegion);
  map.data.addListener("mouseout", mouseOutOfRegion);

  auxData("Eco2");

  var selectBox = document.getElementById("movilidad");
  google.maps.event.addDomListener(selectBox, "change", function () {
    clearCensusData();
    console.log(selectBox.options[selectBox.selectedIndex].value);
    auxData(selectBox.options[selectBox.selectedIndex].value);
  });

  let actualUTAMInfo = "";
  let pInfo = document.createElement("p");
  let tooltip = document.getElementById("tooltip");

  map.data.addListener("mouseover", function (event) {
    event.feature.setProperty("isColorful", true);
    actualUTAMInfo +=
      "<strong>UTAM Nombre: </strong>" + event.feature.j.UTAMNombre + "<br>";
    actualUTAMInfo +=
      "<strong>UTAM Localidad: </strong>" + event.feature.j.LOCNombre + "<br>";
    actualUTAMInfo +=
      "<strong>UTAM Municipio: </strong>" + event.feature.j.MUNNombre;
    pInfo.innerHTML = actualUTAMInfo;
    tooltip.appendChild(pInfo);
  });

  map.data.addListener("mouseout", function (event) {
    event.feature.setProperty("isColorful", false);
    actualUTAMInfo = "";
  });
}

function clearCensusData() {
  minVal = Number.MAX_VALUE;
  maxVal = -Number.MAX_VALUE;
  map.data.forEach(function (row) {
    row.setProperty("census_variable", undefined);
  });
  document.getElementById("tooltip").style.display = "none";
  document.getElementById("data-caret").style.display = "none";
}

function styleFeature(feature) {
  var low = [5, 69, 54];
  var high = [151, 83, 34];

  // delta represents where the value sits between the min and max
  var delta =
    (feature.getProperty("bicycle_data") - minVal) / (maxVal - minVal);

  var color = [];
  for (var i = 0; i < 3; i++) {
    // calculate an integer color based on the delta
    color[i] = (high[i] - low[i]) * delta + low[i];
  }

  // determine whether to show this shape or not
  var showRow = true;
  if (
    feature.getProperty("bicycle_data") == null ||
    isNaN(feature.getProperty("bicycle_data"))
  ) {
    showRow = false;
  }

  var outlineWeight = 0.5,
    zIndex = 1;
  if (feature.getProperty("state") === "hover") {
    outlineWeight = zIndex = 2;
  }

  return {
    strokeWeight: outlineWeight,
    strokeColor: "#fff",
    zIndex: zIndex,
    fillColor: "hsl(" + color[0] + "," + color[1] + "%," + color[2] + "%)",
    fillOpacity: 0.75,
    visible: showRow,
  };
}

function auxData(requestedStat) {
  $.ajax({
    type: "GET",
    url: "/googleMaps/datos/Ecomovilidad.csv",
    dataType: "text",
    success: function (data) {
      processData(data, requestedStat);
    },
  });
}

function processData(allText, requestedStat) {
  var allTextLines = allText.split(/\r\n|\n/);
  var headers = allTextLines[0].split(",");
  var loaded = {};

  index = dict[requestedStat];
  minVal = 100;
  maxVal = 0;

  for (var i = 1; i < allTextLines.length; i++) {
    var data = allTextLines[i].split(",");
    if (data.length == headers.length) {
      UTAMName = data[0];
      loaded[UTAMName] = Number(data[index]);
      if (loaded[UTAMName] < minVal) {
        minVal = loaded[UTAMName];
      }
      if (loaded[UTAMName] > maxVal) {
        maxVal = loaded[UTAMName];
      }
      map.data
        .getFeatureById(UTAMName)
        .setProperty("bicycle_data", loaded[UTAMName]);
    }
  }
  document.getElementById("min").textContent = minVal.toLocaleString();
  document.getElementById("max").textContent = maxVal.toLocaleString();
}

function mouseInToRegion(e) {
  e.feature.setProperty("state", "hover");
  var percent =
    ((e.feature.getProperty("bicycle_data") - minVal) / (maxVal - minVal)) *
    100;

  // update the label
  document.getElementById("data-label").textContent = "Porcentaje";
  document.getElementById("data-value").textContent = e.feature
    .getProperty("bicycle_data")
    .toLocaleString();
  document.getElementById("tooltip").style.display = "block";
  document.getElementById("data-caret").style.display = "block";
  document.getElementById("data-caret").style.paddingLeft = percent + "%";
}

function mouseOutOfRegion(e) {
  e.feature.setProperty("state", "normal");
}
