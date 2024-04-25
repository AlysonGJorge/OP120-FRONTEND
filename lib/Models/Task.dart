class Task {
  late int id_atividade;
  late String ds_titulo;
  late String ds_atividade;
  late String dt_limite;


  Task(this.id_atividade, this.ds_titulo, this.ds_atividade, this.dt_limite);

  Task.fromJson(Map<String, dynamic> json) {
    id_atividade = json['id_atividade'];
    ds_titulo = json['ds_titulo'];
    ds_atividade = json['ds_atividade'];
    dt_limite = json['dt_limite'];
  }
}