var map;
var minVal;
var maxVal;
var reportSelected = "Eco";
var date = "2";

const files = {
  Eco: "/googleMaps/datos/Ecomovilidad.csv",
  SITP: "/googleMaps/datos/SITP.csv",
  Transmilenio: "/googleMaps/datos/Transmilenio.csv",
  Particulares: "/googleMaps/datos/Privado.csv",
};
const dict = { "2": 1, "3": 2, "4": 3, "5": 4, "6": 5, "7": 6 };

window.initMap = async function () {
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

  auxData();

  var selectBox = document.getElementById("movilidad");
  google.maps.event.addDomListener(selectBox, "change", function () {
    reportSelected = selectBox.options[selectBox.selectedIndex].value;
    clearCensusData();
    auxData();
  });

  var selectBox2 = document.getElementById("fecha");
  google.maps.event.addDomListener(selectBox2, "change", function () {
    date = selectBox2.options[selectBox2.selectedIndex].value;
    clearCensusData();
    auxData();
  });
};

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

function auxData() {
  $.ajax({
    type: "GET",
    url: files[reportSelected],
    dataType: "text",
    success: function (data) {
      processData(data);
    },
  });
}

function processData(allText) {
  var allTextLines = allText.split(/\r\n|\n/);
  var headers = allTextLines[0].split(",");
  var loaded = {};

  index = dict[date];
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

let actualUTAMInfo = "";

function mouseInToRegion(e) {
  e.feature.setProperty("state", "hover");
  var percent =
    ((e.feature.getProperty("bicycle_data") - minVal) / (maxVal - minVal)) *
    100;

  // What was previously:
  actualUTAMInfo = "";
  actualUTAMInfo +=
    "<strong>UTAM Nombre: </strong>" + e.feature.j.UTAMNombre + "<br>";
  actualUTAMInfo +=
    "<strong>UTAM Localidad: </strong>" + e.feature.j.LOCNombre + "<br>";
  actualUTAMInfo += "<strong>UTAM Municipio: </strong>" + e.feature.j.MUNNombre;

  // update the label
  document.getElementById("data-label").textContent = "Porcentaje";
  document.getElementById("data-value").textContent = e.feature
    .getProperty("bicycle_data")
    .toLocaleString();
  document.getElementById("utam-info").innerHTML = actualUTAMInfo;
  document.getElementById("tooltip").style.display = "block";
  document.getElementById("data-caret").style.display = "block";
  document.getElementById("data-caret").style.paddingLeft = percent + "%";
}

function mouseOutOfRegion(e) {
  e.feature.setProperty("state", "normal");
  actualUTAMInfo = "";
}
