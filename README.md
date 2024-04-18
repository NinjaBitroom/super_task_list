# super_task_list

Aplicativo de Lista de Tarefas com Autenticação

## Objetivo

Desenvolver um aplicativo Flutter que utilize Firebase ou Supabase para gerenciamento de 
autenticação de usuários e armazenamento de dados em tempo real.

## Como configurar

Na pasta `lib`, crie um arquivo chamado `key_supabase.dart` e coloque o seguinte conteúdo:

```dart
class KeySupabase {
  static const url = '';
  static const anonKey = '';
}
```

Substitua pela sua chave de api do Supabase.

No Supabase crie uma tabela `tasks` com as seguintes colunas:
- id: int
- created_at: timestamp
- title: text
- done: bool `default: false`
- user: uuid `vinculado com: auth.users.id`

Em `Authentication > URL Configuration` do projeto, adicione as seguintes configuraçõs:
- Site URL: io.github.ninjabitroom://super_task_list/login-callback
- Redirect URLs: io.github.ninjabitroom://super_task_list/*

Verifique se `{{ .ConfirmationURL }}` está sendo passado para o template do email de 
`Reset Password`
