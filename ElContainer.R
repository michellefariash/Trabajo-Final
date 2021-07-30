# instalando rvest

library('rvest')

# abriendo página web en la sección productos 
elcontainerCl <- read_html ("https://www.elcontainer.cl/hogar")

# revisando el contenido de fernapetCl
print(html_text(elcontainerCl))

# simulando navegación en 3 páginas

for (numPagina in 1:3) {
  print("=====================================================================================================================")
  print(paste("Navegando por el num de pagina:",numPagina))
  urlelcontainerCl <- paste("https://www.elcontainer.cl/hogar?p=",numPagina,sep = "")
  print(urlelcontainerCl)
  elcontainerCl <- read_html(urlelcontainerCl)
  print(html_text(elcontainerCl))
}

#obteniendo información de los productos en div
elcontainerCl <- read_html("https://www.elcontainer.cl/hogar")
tablaProductoselcontainerCl <- html_nodes(elcontainerCl, css = ".product_list.grid.row")
print(html_text(tablaProductoselcontainerCl))

#reconociendo div de producto
elcontainerCl <- read_html("https://www.elcontainer.cl/hogar")
divProducto <- html_nodes(elcontainerCl, css = ".product-container")
print(html_text(tablaProductoselcontainerCl))

# obteniendo los precios de la tabla
elcontainerCl <- read_html("https://www.elcontainer.cl/hogar")
precioselcontainerCl <- html_nodes(tablaProductoselcontainerCl, css = ".price")
print(length(precioselcontainerCl))
print(html_text(precioselcontainerCl[1:15]))

# mostrando todos los precios obtenidos
for (posicionElemento in 1:length(precioselcontainerCl)) {
  print(html_text(precioselcontainerCl[posicionElemento]))
}

# obteniendo los nombres de los productos
nombresProductoselcontainerCl <- html_nodes(tablaProductoselcontainerCl, css=".product-name")
print(length(nombresProductoselcontainerCl))

# mostrando todos los nombres obtenidos y extrayendo los links
for (nombreElemento in nombresProductoselcontainerCl) {
  print(html_text(nombreElemento))
  print(html_attr(nombreElemento,"href"))
}

# entrando a los diferentes productos
for (nombreElemento in nombresProductoselcontainerCl) {
  print("=========================================================================================")
  print(html_text(nombreElemento))
  # se extrae el link del producto
  urlProducto <- html_attr(nombreElemento,"href")
  print(urlProducto)
  # lee la página del producto
  paginaProducto <- read_html(urlProducto)
  # precio del producto contenido en la página del producto
  precioProducto <- obtenerPrecioProducto(paginaProducto)
  print(is.na(precioProducto))
  print(!is.na(precioProducto))
  if(!is.na(precioProducto)){
    print(precioProducto)
  }else{
    print("no hay precio")
  }
}

#limpiando data
{precioProducto <- html_nodes(paginaProducto, css = ".price.product-price")
precioproductolimpio <- html_text(precioProducto)
precioproductolimpio <- gsub("\n", "" ,precioproductolimpio)
precioproductolimpio <- gsub("\t", "" ,precioproductolimpio)
precioproductolimpio <- gsub("            ", "" ,precioproductolimpio)
precioproductolimpio <- gsub("[$]", "" ,precioproductolimpio)
precioproductolimpio <- gsub("[.]", "" ,precioproductolimpio)
print(precioproductolimpio)
}










