import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"];

  connect() {
    fetch(`/cryptos`, {
      headers: { accept: "application/json" },
    })
      .then((response) => response.json())
      .then((data) => {
        this.resultsTarget.innerHTML = "";
        data.forEach(([id, name, symbol, price, variation_24h]) => {
          const link = document.createElement("a");
          link.classList.add("result-crypto");
          link.href = `/cryptos/${id}`;

          const infoLinkDiv = document.createElement("div");
          infoLinkDiv.classList.add("info-link");

          const nameSymbolDiv = document.createElement("div");
          nameSymbolDiv.classList.add("name-symbol");

          const symbolSpan = document.createElement("span");
          symbolSpan.classList.add("symbol");
          symbolSpan.textContent = symbol;

          nameSymbolDiv.appendChild(document.createTextNode(name + " "));
          nameSymbolDiv.appendChild(symbolSpan);

          infoLinkDiv.appendChild(nameSymbolDiv);

          const priceVolumeDiv = document.createElement("div");
          priceVolumeDiv.classList.add("price-volume");

          const priceSpan = document.createElement("span");
          priceSpan.classList.add("price");
          priceSpan.textContent = `$${price}`;

          priceVolumeDiv.appendChild(priceSpan);

          const variationSpan = document.createElement("span");
          variationSpan.classList.add("variation-24h");

          if (parseFloat(variation_24h) >= 0) {
            variationSpan.textContent = `+${variation_24h}%`;
            variationSpan.classList.add("positif");
          } else {
            variationSpan.textContent = `${variation_24h}%`;
            variationSpan.classList.add("negatif");
          }

          priceVolumeDiv.appendChild(variationSpan);

          link.appendChild(infoLinkDiv);
          link.appendChild(priceVolumeDiv);

          this.resultsTarget.appendChild(link);
        });
      });
  }

  search() {
    const query = this.inputTarget.value.trim();

    fetch(`/cryptos?search=${query}`, {
      headers: { accept: "application/json" },
    })
      .then((response) => response.json())
      .then((data) => {
        this.resultsTarget.innerHTML = "";
        data.forEach(([id, name, symbol, price, variation_24h]) => {
          const link = document.createElement("a");
          link.classList.add("result-crypto");
          link.href = `/cryptos/${id}`;

          const infoLinkDiv = document.createElement("div");
          infoLinkDiv.classList.add("info-link");

          const nameSymbolDiv = document.createElement("div");
          nameSymbolDiv.classList.add("name-symbol");

          const symbolSpan = document.createElement("span");
          symbolSpan.classList.add("symbol");
          symbolSpan.textContent = symbol;

          nameSymbolDiv.appendChild(document.createTextNode(name + " "));
          nameSymbolDiv.appendChild(symbolSpan);

          infoLinkDiv.appendChild(nameSymbolDiv);

          const priceVolumeDiv = document.createElement("div");
          priceVolumeDiv.classList.add("price-volume");

          const priceSpan = document.createElement("span");
          priceSpan.classList.add("price");
          priceSpan.textContent = `$${price}`;

          priceVolumeDiv.appendChild(priceSpan);

          const variationSpan = document.createElement("span");
          variationSpan.classList.add("variation-24h");

          if (parseFloat(variation_24h) >= 0) {
            variationSpan.textContent = `+${variation_24h}%`;
            variationSpan.classList.add("positif");
          } else {
            variationSpan.textContent = `${variation_24h}%`;
            variationSpan.classList.add("negatif");
          }

          priceVolumeDiv.appendChild(variationSpan);

          link.appendChild(infoLinkDiv);
          link.appendChild(priceVolumeDiv);

          this.resultsTarget.appendChild(link);
        });
      });
  }
}
