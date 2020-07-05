import { loadData } from "./loadData.js";

const projection = d3.geoAlbers();
const pathGenerator = d3.geoPath().projection(projection);

let svg = d3.select("body").append("svg");

let bogotaMap = svg.append("g").data([null]);
let zoom = loadData();
d3.json("ZAT.json").then((data) => {
  const ZATValues = topojson.feature(data, data.objects.ZAT);
  console.log(ZATValues);
  bogotaMap
    .selectAll("path")
    .data(ZATValues.features)
    .enter()
    .append("path")
    .attr("class", "ZAT")
    .attr("d", pathGenerator)
    .append("title")
    .text("ZAT id: ")
    .text((d) => d.properties.ZAT);

  let scale = 30;
  let coordinatesBogotaMap = bogotaMap.node().getBBox();
  bogotaMap.attr(
    "transform",
    `scale(${scale}) translate(-${coordinatesBogotaMap.x} -${coordinatesBogotaMap.y})`
  );

  // svg.call(
  //   zoom.transform,
  //   d3.zoomIdentity
  //     .translate(-coordinatesBogotaMap.x, -coordinatesBogotaMap.y)
  //     .scale(scale)
  // );
  svg.call(
    d3.zoom().on("zoom", function () {
      bogotaMap.attr("transform", d3.event.transform);
    })
  );
});
