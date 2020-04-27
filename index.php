<?php

use taskforce\core\Task;

require_once 'vendor/autoload.php';

$new_task = new Task(123, 987);

echo 'Текущий статус задания: ' . $new_task->getStatus() . '<br>';

assert($new_task->getStatus() == Task::STATUS_NEW, 'первоначально статус new');
assert($new_task->getNextStatus("action_cancel") == Task::STATUS_CANCELED, 'после отмены статус должен быть canceled');
assert($new_task->getNextStatus("action_respond") == null, 'после отклика статус не меняется');
assert($new_task->getNextStatus("action_apply") == Task::STATUS_DONE, 'после принятия статус должен быть done');
assert($new_task->getNextStatus("action_fail") == Task::STATUS_FAILED, 'после отказа от выполенения статус должен быть failed');

assert($new_task->getActionList(123) == Task::ACTION_CANCEL, 'при статусе задания new, у заказчика есть возможность его отменить');
assert($new_task->getActionList(987) == Task::ACTION_RESPOND, 'при статусе задания new, у фрилансера есть возможность откликнуться на него');

$new_task->setStatus(Task::STATUS_IN_WORK);

echo 'Текущий статус задания: ' . $new_task->getStatus();

assert($new_task->getActionList(123) == Task::ACTION_APPLY, 'при статусе задания in work, у заказчика есть возможность его принять');
assert($new_task->getActionList(987) == Task::ACTION_FAIL, 'при статусе задания in work, у фрилансера есть возможность отказаться от выполения (провалить выполнение)');
