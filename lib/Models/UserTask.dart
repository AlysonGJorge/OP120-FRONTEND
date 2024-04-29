class UserTask {
  late int id_user;
  late String id_atividade;
  late String dt_entrega;
  late String nr_nota;


  UserTask(this.id_user, this.id_atividade, this.dt_entrega, this.nr_nota);

  UserTask.fromJson(Map<String, dynamic> json) {
    id_user = json['id_user'];
    id_atividade = json['id_atividade'];
    dt_entrega = json['dt_entrega'];
    nr_nota = json['nr_nota'];
  }
}