from sqlalchemy import create_engine, text
import pandas as pd

# CONFIGURACIÓN DE LA BASE DE DATOS 
DB_HOST = "localhost"
DB_PORT = "3306"
DB_USER = "root"
DB_PASSWORD = "root123"         
DB_NAME = "translogistica_db"

ARCHIVO_EXCEL = "datos_translogistica.xlsx"
ARCHIVO_REPORTE = "reporte.txt"


def pipeline():
    try:
        # 1. CONEXIÓN
        database_url = (
            f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}"
            f"@{DB_HOST}:{DB_PORT}/{DB_NAME}"
        )
        engine = create_engine(database_url)

        with engine.connect() as connection:
            print("CONEXIÓN EXITOSA")

            # 2. CONSULTAR LA BASE DE DATOS
            df_clientes = pd.read_sql_query(text("SELECT * FROM clientes"), connection)
            df_envios = pd.read_sql_query(text("SELECT * FROM envios"), connection)
            df_rutas = pd.read_sql_query(text("SELECT * FROM rutas"), connection)
            df_satisfaccion = pd.read_sql_query(text("SELECT * FROM satisfacción"), connection)
            df_vehiculos = pd.read_sql_query(text("SELECT * FROM vehiculos"), connection)

        # 3. GUARDAR LAS CONSULTAS EN UN EXCEL (una hoja por tabla)
        with pd.ExcelWriter(ARCHIVO_EXCEL, engine="openpyxl") as writer:
            df_clientes.to_excel(writer, sheet_name="clientes", index=False)
            df_envios.to_excel(writer, sheet_name="envios", index=False)
            df_rutas.to_excel(writer, sheet_name="rutas", index=False)
            df_satisfaccion.to_excel(writer, sheet_name="satisfaccion", index=False)
            df_vehiculos.to_excel(writer, sheet_name="vehiculos", index=False)
        print(f"Excel generado: {ARCHIVO_EXCEL}")

        # 4. VOLVER A LEER EL EXCEL Y HACER LOS CÁLCULOS
        envios = pd.read_excel(ARCHIVO_EXCEL, sheet_name="envios")
        satisfaccion = pd.read_excel(ARCHIVO_EXCEL, sheet_name="satisfaccion")

        total_envios = len(envios)
        precio_promedio = envios["precio_envío"].mean()
        precio_maximo = envios["precio_envío"].max()
        precio_minimo = envios["precio_envío"].min()
        envios_por_estado = envios["estado"].value_counts()
        satisfaccion_promedio = satisfaccion["calificacion"].mean()

        # 5. GENERAR EL REPORTE EN UN ARCHIVO DE TEXTO
        with open(ARCHIVO_REPORTE, "w", encoding="utf-8") as f:
            f.write("REPORTE TRANSLOGISTICA\n")
            f.write("=" * 40 + "\n\n")
            f.write(f"Total de envíos: {total_envios}\n")
            f.write(f"Precio promedio: ${precio_promedio:,.0f}\n")
            f.write(f"Precio máximo: ${precio_maximo:,.0f}\n")
            f.write(f"Precio mínimo: ${precio_minimo:,.0f}\n\n")
            f.write("Envíos por estado:\n")
            f.write(envios_por_estado.to_string() + "\n\n")
            f.write(f"Calificación promedio de satisfacción: {satisfaccion_promedio:.2f}\n")

        print(f"Reporte generado: {ARCHIVO_REPORTE}")
        print("PROCESO FINALIZADO CORRECTAMENTE")

    except Exception as e:
        print("ERROR:")
        print(e)


if __name__ == "__main__":
    print("SISTEMA TRANSLOGISTICA - PIPELINE")
    pipeline()