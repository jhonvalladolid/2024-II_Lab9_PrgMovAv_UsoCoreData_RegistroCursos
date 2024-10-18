//
//  ViewControllerDetalleCurso.swift
//  UsoCoreData_CursosTecsup
//
//  Created by Mac05 on 17/10/24.
//

import UIKit

class ViewControllerDetalleCurso: UIViewController {
    
    
    @IBOutlet weak var txtNombreCurso: UILabel!
    @IBOutlet weak var txtNotaLaboratorio: UILabel!
    @IBOutlet weak var txtNotaPractica: UILabel!
    @IBOutlet weak var txtNotaExamen: UILabel!
    @IBOutlet weak var txtResultadoNota: UILabel!
    @IBOutlet weak var txtResultado: UILabel!
    
    // Propiedad para recibir el curso desde la vista anterior
    var curso: Cursos?

    override func viewDidLoad() {
        super.viewDidLoad()
        mostrarResultadoCurso()
    }
    
    // Función para mostrar el resultado del curso
    func mostrarResultadoCurso() {
        guard let curso = curso else { return }
        
        txtNombreCurso.text = curso.nombre ?? "Sin Nombre"
        txtNotaLaboratorio.text = "\(curso.promedioLaboratorios)"
        txtNotaPractica.text = "\(curso.promedioPracticas)"
        txtNotaExamen.text = "\(curso.examenFinal)"
        
        // Calcular el promedio
        let promedioFinal = (curso.promedioPracticas + curso.promedioLaboratorios + curso.examenFinal) / 3.0
        
        // Determinar el resultado y el icono
        let resultadoTexto: String
        let icono: String
        
        if promedioFinal >= 11 {
            resultadoTexto = "Aprobado"
            icono = "😇"
        } else {
            resultadoTexto = "Reprobado"
            icono = "😞"
        }
        
        txtResultadoNota.text = "Resultado Final: \(String(format: "%.2f", promedioFinal))"
        txtResultado.text = "\(icono) \(resultadoTexto)"
    }

    @IBAction func btnVolver(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEliminar(_ sender: Any) {
        guard let curso = curso else { return }
        
        // Acceder al contexto de Core Data
        let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Eliminar el curso
        contexto.delete(curso)
        
        // Guardar los cambios
        do {
            try contexto.save()
            navigationController?.popViewController(animated: true) // Volver a la vista anterior
        } catch {
            print("Error al eliminar el curso: \(error.localizedDescription)")
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
