//
//  ViewController.swift
//  UsoCoreData_CursosTecsup
//
//  Created by Mac05 on 16/10/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    // Lista que contendrá los cursos obtenidos de Core Data
    var cursos: [Cursos] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // Función que se ejecuta cada vez que la vista aparece, se llama para actualizar los cursos
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        obtenerCursos()
        tableView.reloadData()
    }
    
    // Función para obtener los cursos almacenados en Core Data
    func obtenerCursos() {
        let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            cursos = try contexto.fetch(Cursos.fetchRequest()) as! [Cursos]
        } catch {
            print("Error al obtener los cursos de Core Data")
        }
    }

    // Número de filas en la tabla, es el número de cursos que tenemos
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cursos.count
    }

    // Configuración de la celda para cada fila de la tabla
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Crear una nueva celda
        let cell = UITableViewCell()
        let curso = cursos[indexPath.row]
        
        // Calcular el promedio de las tres notas
        let promedioFinal = (curso.promedioPracticas + curso.promedioLaboratorios + curso.examenFinal) / 3.0
        
        // Configurar la celda con el nombre del curso y el promedio final
        cell.textLabel?.text = "\(curso.nombre ?? "Sin Nombre") - Promedio Final: \(String(format: "%.2f", promedioFinal))"
        
        // Cambiar el color de fondo de la celda dependiendo si el curso está aprobado o reprobado
        if curso.promedioPracticas >= 11 && curso.promedioLaboratorios >= 11 && curso.examenFinal >= 11 {
            cell.backgroundColor = UIColor.green // Aprobado
        } else {
            cell.backgroundColor = UIColor.red // Reprobado
        }
        
        return cell
    }

    // Función que se ejecuta al agregar un nuevo curso
    @IBAction func agregarCurso(_ sender: Any) {
        performSegue(withIdentifier: "segue_AgregarCurso", sender: nil)
    }
    
    // Función que se ejecuta al tocar una fila, para mostrar detalles del curso
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let curso = cursos[indexPath.row]
        performSegue(withIdentifier: "segue_DetalleCurso", sender: curso)
    }
    
    // Preparar para la transición a la vista de detalles
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_DetalleCurso" {
            // Asegúrate de que el destino sea ViewControllerDetalleCurso
            if let detalleVC = segue.destination as? ViewControllerDetalleCurso {
                // Pasa el curso seleccionado al controlador de detalles
                detalleVC.curso = sender as? Cursos
            }
        }
    }
}

