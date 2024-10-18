//
//  ViewControllerAgregarCurso.swift
//  UsoCoreData_CursosTecsup
//
//  Created by Mac05 on 17/10/24.
//

import UIKit

class ViewControllerAgregarCurso: UIViewController {
    
    @IBOutlet weak var txtTitulo: UILabel!
    @IBOutlet weak var txtNombreCurso: UITextField!
    @IBOutlet weak var txtNotaLaboratorio: UITextField!
    @IBOutlet weak var txtNotaPractica: UITextField!
    @IBOutlet weak var txtNotaExamen: UITextField!
    
    // Propiedad para recibir el curso que se va a editar
    var cursoAEditar: Cursos?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Si hay un curso para editar, cargar los datos en los campos y cambiar el título
        if let curso = cursoAEditar {
            txtTitulo.text = "Editar Curso"
            txtNombreCurso.text = curso.nombre
            txtNotaLaboratorio.text = String(curso.promedioLaboratorios)
            txtNotaPractica.text = String(curso.promedioPracticas)
            txtNotaExamen.text = String(curso.examenFinal)
        } else {
            // Si no hay un curso, se está agregando un nuevo curso
            txtTitulo.text = "Agregar Curso"
        }
    }
    
    @IBAction func btnGuardar(_ sender: Any) {
        // Obtener el contexto de Core Data
        let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Si hay un curso a editar, actualizar sus propiedades
        if let curso = cursoAEditar {
            curso.nombre = txtNombreCurso.text
            curso.promedioLaboratorios = Double(txtNotaLaboratorio.text ?? "0") ?? 0.0
            curso.promedioPracticas = Double(txtNotaPractica.text ?? "0") ?? 0.0
            curso.examenFinal = Double(txtNotaExamen.text ?? "0") ?? 0.0
        } else {
            // Si no, crear un nuevo curso
            let nuevoCurso = Cursos(context: contexto)
            nuevoCurso.nombre = txtNombreCurso.text
            nuevoCurso.promedioLaboratorios = Double(txtNotaLaboratorio.text ?? "0") ?? 0.0
            nuevoCurso.promedioPracticas = Double(txtNotaPractica.text ?? "0") ?? 0.0
            nuevoCurso.examenFinal = Double(txtNotaExamen.text ?? "0") ?? 0.0
        }

        // Guardar los cambios en el contexto
        do {
            try contexto.save()
            // Volver a la vista anterior
            navigationController?.popViewController(animated: true)
        } catch {
            print("Error al guardar el curso: \(error)")
        }
    }
    
    @IBAction func btnCancelar(_ sender: Any) {
        // Regresar a la vista anterior
        navigationController?.popViewController(animated: true)
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
