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
        data.forEach(([id, name, symbol, price, variation_24h, logo_url]) => {
          const link = document.createElement("a");
          link.classList.add("result-crypto");
          link.href = `/cryptos/${id}`;

          const infoLinkDiv = document.createElement("div");
          infoLinkDiv.classList.add("info-link");

          const logoNameWrapper = document.createElement("div");
          logoNameWrapper.classList.add("logo-wrapper");

          const logoImg = document.createElement("img");
          logoImg.src = `/${symbol.toLowerCase()}.png`;
          logoImg.alt = `${name} logo`;
          logoImg.classList.add("crypto-logo");

          const nameSymbolDiv = document.createElement("div");
          nameSymbolDiv.classList.add("name-symbol");

          nameSymbolDiv.appendChild(document.createTextNode(name + " "));
          
          const symbolSpan = document.createElement("span");
          symbolSpan.classList.add("symbol");
          symbolSpan.textContent = symbol;
          nameSymbolDiv.appendChild(symbolSpan);

          logoNameWrapper.appendChild(logoImg);
          logoNameWrapper.appendChild(nameSymbolDiv);

          infoLinkDiv.appendChild(logoNameWrapper);

          const priceVolumeDiv = document.createElement("div");
          priceVolumeDiv.classList.add("price-volume");

          const priceSpan = document.createElement("span");
          priceSpan.classList.add("price");
          priceSpan.textContent = `$${parseFloat(price).toFixed(2)}`;

          priceVolumeDiv.appendChild(priceSpan);

          const variationSpan = document.createElement("span");
          variationSpan.classList.add("variation-24h");

          const formattedVariation = parseFloat(variation_24h).toFixed(2);

          if (parseFloat(variation_24h) >= 0) {
            variationSpan.textContent = `+${formattedVariation}%`;
            variationSpan.classList.add("positif");
          } else {
            variationSpan.textContent = `${formattedVariation}%`;
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
        if (data.length === 0) {
          const noResultsMessage = document.createElement("p");
          noResultsMessage.textContent = "No cryptocurrency found.";
          noResultsMessage.classList.add("no-results-message");
          this.resultsTarget.appendChild(noResultsMessage);
          return;
        }
        data.forEach(([id, name, symbol, price, variation_24h, logo_url]) => {
          const link = document.createElement("a");
          link.classList.add("result-crypto");
          link.href = `/cryptos/${id}`;

          const infoLinkDiv = document.createElement("div");
          infoLinkDiv.classList.add("info-link");

          const logoNameWrapper = document.createElement("div");
          logoNameWrapper.classList.add("logo-wrapper");

          const logoImg = document.createElement("img");
          logoImg.src = `/${symbol.toLowerCase()}.png`;
          logoImg.alt = `${name} logo`;
          logoImg.classList.add("crypto-logo");

          const nameSymbolDiv = document.createElement("div");
          nameSymbolDiv.classList.add("name-symbol");

          nameSymbolDiv.appendChild(document.createTextNode(name + " "));
          
          const symbolSpan = document.createElement("span");
          symbolSpan.classList.add("symbol");
          symbolSpan.textContent = symbol;
          nameSymbolDiv.appendChild(symbolSpan);

          logoNameWrapper.appendChild(logoImg);
          logoNameWrapper.appendChild(nameSymbolDiv);

          infoLinkDiv.appendChild(logoNameWrapper);

          const priceVolumeDiv = document.createElement("div");
          priceVolumeDiv.classList.add("price-volume");

          const priceSpan = document.createElement("span");
          priceSpan.classList.add("price");
          priceSpan.textContent = `$${parseFloat(price).toFixed(2)}`;

          priceVolumeDiv.appendChild(priceSpan);

          const variationSpan = document.createElement("span");
          variationSpan.classList.add("variation-24h");

          const formattedVariation = parseFloat(variation_24h).toFixed(2);

          if (parseFloat(variation_24h) >= 0) {
            variationSpan.textContent = `+${formattedVariation}%`;
            variationSpan.classList.add("positif");
          } else {
            variationSpan.textContent = `${formattedVariation}%`;
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
