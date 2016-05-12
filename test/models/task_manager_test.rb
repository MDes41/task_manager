require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  include TestHelpers
  def test_it_creates_a_task
    task_manager.create({
      :title            => 'a title',
      :description     => 'a description'
      })

    task = task_manager.find(1)
    assert_equal 'a title', task.title
    assert_equal 'a description', task.description
    assert_equal 1, task.id
  end

  def test_it_can_find_all_in_database
    task_manager.create({
      :title            => 'first title',
      :description     => 'first description'
      })
    task_manager.create({
      :title            => 'second title',
      :description     => 'second description'
      })

    tasks = task_manager.all
    assert_equal 2, tasks.count
    assert_equal "second description", tasks.last.description
    assert_equal "first description", tasks.first.description
  end

  def test_it_can_find_by_id
    task_manager.create({
      :title            => 'first title',
      :description     => 'first description'
      })
    task_manager.create({
      :title            => 'second title',
      :description     => 'second description'
      })
    assert_equal 1, task_manager.find(1).id
    assert_equal "second title", task_manager.find(2).title
  end

  def test_update_with_create_an_updated_task
    task_manager.create({
      :title            => 'first title',
      :description     => 'first description'
      })
    assert_equal 1, task_manager.all.first.id
    assert_equal "first title", task_manager.all.first.title
    assert_equal "first description", task_manager.all.first.description

    task_manager.update(1, { title: "updated title", description: "updated description"} )

    assert_equal 1, task_manager.all.first.id
    assert_equal "updated title", task_manager.all.first.title
    assert_equal "updated description", task_manager.all.first.description
  end

  def test_destroy_deletes_a_task_and_the_task_no_longer_exists
    task_manager.create({ title: "first title", description: "first description" })
    task_manager.create({ title: "delete title", description: "delete description" })
    task_manager.create({ title: "last title", description: "last description" })

    assert_equal 3, task_manager.all.count
    assert_equal [1, 2, 3], task_manager.all.map(&:id)

    task_manager.destroy(2)

    assert_equal 2, task_manager.all.count
    assert_equal [1, 3], task_manager.all.map(&:id)

  end


end
