//
//  ViewControllerAgregarCurso.swift
//  UsoCoreData_CursosTecsup
//
//  Created by Mac05 on 17/10/24.
//

import UIKit

class ViewControllerAgregarCurso: UIViewController {

    @IBOutlet weak var txtNombreCurso: UITextField!
    @IBOutlet weak var txtNotaLaboratorio: UITextField!
    @IBOutlet weak var txtNotaPractica: UITextField!
    @IBOutlet weak var txtNotaExamen: UITextField!
    
    var anteriorVC = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnGuardar(_ sender: Any) {
        // Obtener el contexto de Core Data
        let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Crear un nuevo objeto de curso
        let nuevoCurso = Cursos(context: contexto)
        
        // Asignar valores a las propiedades del nuevo curso
        nuevoCurso.nombre = txtNombreCurso.text
        nuevoCurso.promedioLaboratorios = Double(txtNotaLaboratorio.text ?? "0") ?? 0.0
        nuevoCurso.promedioPracticas = Double(txtNotaPractica.text ?? "0") ?? 0.0
        nuevoCurso.examenFinal = Double(txtNotaExamen.text ?? "0") ?? 0.0

        // Intentar guardar el contexto
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
