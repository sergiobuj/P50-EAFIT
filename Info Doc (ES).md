# P50 Doc (ES)

La aplicación tiene gran parte de su configuración en el archivo 'Customization.plist' que se encuentra en
'P50/P50/Customization.plist'.

El archivo (un xml) tiene la siguiente estructura:

Llave			Valor			
rss_feeds		Diccionario que contiene las direcciones de los rss que se quieren consumir.
				La llave en cada una de estas entradas es el nombre del UIViewController que presentará esa información.

				
pages			Arreglo de arreglos de diccionarios. Cada arreglo contiene los elementos que se presentarán en cada pantalla de
				la aplicación (botones).
				Cada elemento está especificado como un diccionario que puede ser expandido para ofrecer mayor personalización.
				Las llaves principales son 'title', 'viewController', posX, posY, sizeH, sizeW.
				
				Los valores de posXY y sizeHW se deben especificar como un flotante que representa el porcentaje del valor total de la 
				pantalla del dispositivo, estos valores representan el orgigen del botón, que corresponde al igual que la pantalla del 
				teléfono a la esquina superior izquierda.
				Así si se quiere que un botón aparezca desde la mitad de la pantalla tanto horizontal como verticalmente, los valores deben
				corresponder a 50%.
				Tanto la posición como el tamaño deben ser determinados como porcentajes del tamaño de la pantalla del dispositivo
				(expresados como flotantes).

				El valor de viewControler debe ser el nombre dado al controlador de vista (no debe tener extensiones).

				El título será el texto que aparece en el botón.
				Todos los títulos y textos son localizados. Los títulos de los botones se deben especificar con la llave del archivo
				de localización correspondiente al texto del botón (archivo con extensión 'strings').
				Así, si se agrega un botón con título 'big_red_button', en los archivos '.strings' de cada idioma, debe aparecer la correspondiente
				localización de ese texto así: "big_red_button" = "Big red Button".
				*Se debe tener en cuenta la longitud de los textos en el momento de ser localizados, ya que parte del título puede no aparecer.


videos (temp)	Este arreglo de diccionarios contiene la ubicación de unos archivos .mov ('videoURL') y los títulos ('title').


No hay un límite de botones que pueda ser presentado en cada pantalla, depende de la necesidad y del diseño de la aplicación.


#Para agregar una vista/controlador nuevo
Se debe crear un UIViewController con la funcionalidad que se desea implementar y crear una entrada con las caracteristicas indicadas
en el arreglo de páginas del archivo 'Customization.plist'. En el campo de viewController debe ir especificado el nombre dado al controlador
de vista (sin extensiones).

# Servicios P50
El cliente actualmente está consultando unos servicios expuestos por dos aplicaciones RoR desplegadas en Heroku y en CloudFoundry,
las dos aplicaciones son idénticas.
La aplicación RoR tiene simplemente la tarea de entregar un JSON con las caracteristicas e información relevante para aplicación
que tendría un servicio de EAFIT.
El método de inicio de sesión no se definió.


Pendiente
---------
* Servicios Web
** Sistema para autenticación. La aplicación es cerrada y restringida para los profesores de la universidad, por eso todos los recursos
deben pasar por el filtro de autenticación.
** Creación de la funcionalidad de talleres asistidos y talleres recomendados.
** Servicio que expone los videos de Proyecto 50.
** Exponer las noticias de forma que se puedan presentar de acuerdo al dispositivo.

* En una próxima versión se puede implementar un sistema de paginación que de acuerdo al número de botones definido por página se
agreguen a páginas siguientes.

