require 'rails_helper'

RSpec.describe "Tasks API", type: :request do
  it 'loads tasks of a project' do
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project, name: "Sample Project", owner: user)
    tasks = FactoryBot.create_list(:task, 3, project: project)

    get api_project_tasks_path(project_id: project.id), params: {
      user_email: user.email,
      user_token: user.authentication_token
    }

    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    expect(json.length).to eq 3
    expect(json[0]["id"]).to eq tasks[0].id
    expect(json[1]["id"]).to eq tasks[1].id
    expect(json[2]["id"]).to eq tasks[2].id
  end
end
