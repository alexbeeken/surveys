class CreateSurveyAndQuestion < ActiveRecord::Migration
  def change
    create_table(:surveys) do |t|
      t.column(:title, :string)

      t.timestamps
    end

    create_table(:questions) do |t|
      t.column(:text, :string)
      t.column(:survey_id, :integer)

      t.timestamps
    end

  end
end
