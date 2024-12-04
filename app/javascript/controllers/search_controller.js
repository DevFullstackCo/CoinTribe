import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
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
  
          // Créer la première div pour name et symbol
          const nameSymbolDiv = document.createElement("div");
          nameSymbolDiv.classList.add("name-symbol");
  
          // Encapsuler symbol dans un span avec une classe spécifique
          const symbolSpan = document.createElement("span");
          symbolSpan.classList.add("symbol");
          symbolSpan.textContent = symbol;
  
          // Ajouter le nom et le symbole à la div
          nameSymbolDiv.appendChild(document.createTextNode(name + " "));
          nameSymbolDiv.appendChild(symbolSpan);
  
          // Créer la deuxième div pour price et volume_24h
          const priceVolumeDiv = document.createElement("div");
          priceVolumeDiv.classList.add("price-volume");
          
          // Insérer la variation_24h avec une classe spécifique
          const variationDiv = document.createElement("span");
          variationDiv.classList.add("variation-24h");
          
          // Appliquer la classe 'negative' si la variation est négative
          if (parseFloat(variation_24h) < 0) {
            variationDiv.classList.add("negative");
          }
  
          variationDiv.textContent = `(${price}) ${variation_24h}`;
  
          priceVolumeDiv.appendChild(variationDiv);
  
          // Ajouter les divs au lien
          link.appendChild(nameSymbolDiv);
          link.appendChild(priceVolumeDiv);
  
          // Ajouter le lien au conteneur des résultats
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
        data.forEach(([id, name, symbol, price,]) => {
          const link = document.createElement("a");
          link.href = `/cryptos/${id}`;
          link.textContent = `${symbol} ${name} (${price})`;
          this.resultsTarget.appendChild(link);
        });
      });
  }
}